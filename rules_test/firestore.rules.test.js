const { readFileSync } = require("node:fs");

const {
  initializeTestEnvironment,
  assertSucceeds,
  assertFails,
} = require("@firebase/rules-unit-testing");

const {
  doc,
  getDoc,
  setDoc,
  updateDoc,
  collection,
  addDoc,
  getDocs,
  query,
  where,
  orderBy,
  deleteDoc,
  serverTimestamp,
} = require("firebase/firestore");

const {
  before,
  after,
  beforeEach,
  test,
} = require("node:test");

const PROJECT_ID = "demo-lawlink360";
let testEnv;

before(async () => {
  testEnv = await initializeTestEnvironment({
    projectId: PROJECT_ID,
    firestore: {
      host: "127.0.0.1",
      port: 8080,
      rules: readFileSync("firestore.rules", "utf8"),
    },
  });
});

beforeEach(async () => {
  await testEnv.clearFirestore();
});

after(async () => {
  await testEnv.cleanup();
});

function validUser(uid) {
  return {
    uid,
    fullName: "Test User",
    email: `${uid}@example.com`,
    phone: "03001234567",
    role: "",
    profileCompleted: false,
    createdAt: serverTimestamp(),
  };
}

function validCopyHouseRequest(uid) {
  return {
    serviceId: "registered_document_copies",
    serviceSubtype: "registered_sale_deed",
    serviceDetails: {
      bookNumber: "10",
      volumeNumber: "2",
      documentNumber: "123",
      dated: "2026-01-15",
    },
    submittedBy: uid,
    status: "submitted",
    caseType: "",
    caseStatus: "",
    firstParty: "",
    secondParty: "",
    caseTitle: "",
    caseNumber: "",
    firNumber: "",
    firYear: "",
    policeStation: "",
    offence: "",
    dated: "",
    courtOrJurisdiction: "",
    judge: "",
    caseDecidedOn: "",
    nextHearingDate: "",
    recordRequested: "",
    recordRequestedList: [],
    purpose: "",
    additionalInformation: "",
    createdAt: serverTimestamp(),
    updatedAt: serverTimestamp(),
  };
}

// ============================================================
// USER PROFILE AND AUTHENTICATION TESTS
// ============================================================

test("Unauthenticated users cannot read a user profile", async () => {
  const db = testEnv.unauthenticatedContext().firestore();

  await assertFails(
    getDoc(doc(db, "users", "userA"))
  );
});

test("A user can create their own valid profile", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  await assertSucceeds(
    setDoc(doc(db, "users", "userA"), validUser("userA"))
  );
});

test("A user cannot create another user's profile", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  await assertFails(
    setDoc(doc(db, "users", "userB"), validUser("userB"))
  );
});

test("A user cannot read another user's profile", async () => {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(
      doc(context.firestore(), "users", "userB"),
      validUser("userB")
    );
  });

  const db = testEnv.authenticatedContext("userA").firestore();

  await assertFails(
    getDoc(doc(db, "users", "userB"))
  );
});

test("A user can complete their initial role selection", async () => {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(
      doc(context.firestore(), "users", "userA"),
      {
        uid: "userA",
        fullName: "Test User",
        email: "userA@example.com",
        phone: "03001234567",
        role: "",
        profileCompleted: false,
        createdAt: serverTimestamp(),
      }
    );
  });

  const db = testEnv.authenticatedContext("userA").firestore();

  await assertSucceeds(
    updateDoc(doc(db, "users", "userA"), {
      role: "client",
    })
  );
});

test("A user cannot change their role a second time", async () => {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(doc(context.firestore(), "users", "userA"), {
      uid: "userA",
      fullName: "Test User",
      email: "userA@example.com",
      phone: "03001234567",
      role: "client",
      profileCompleted: false,
      createdAt: serverTimestamp(),
    });
  });

  const db = testEnv.authenticatedContext("userA").firestore();

  await assertFails(
    updateDoc(doc(db, "users", "userA"), {
      role: "lawyer",
    })
  );
});

test("A user cannot change their role and other profile fields together", async () => {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(doc(context.firestore(), "users", "userA"), {
      uid: "userA",
      fullName: "Test User",
      email: "userA@example.com",
      phone: "03001234567",
      role: "",
      profileCompleted: false,
      createdAt: serverTimestamp(),
    });
  });

  const db = testEnv.authenticatedContext("userA").firestore();

  await assertFails(
    updateDoc(doc(db, "users", "userA"), {
      role: "client",
      fullName: "Changed Name",
    })
  );
});

// ============================================================
// EXISTING COPY HOUSE SECURITY TESTS
// ============================================================

test("A user can submit a valid Copy House request", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  await assertSucceeds(
    addDoc(
      collection(db, "copyHouseRequests"),
      validCopyHouseRequest("userA")
    )
  );
});

test("A user cannot submit a request under another user's identity", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  await assertFails(
    addDoc(
      collection(db, "copyHouseRequests"),
      validCopyHouseRequest("userB")
    )
  );
});

test("An unauthenticated user cannot submit a Copy House request", async () => {
  const db = testEnv.unauthenticatedContext().firestore();

  await assertFails(
    addDoc(
      collection(db, "copyHouseRequests"),
      validCopyHouseRequest("userA")
    )
  );
});

test("A user cannot submit an unsupported Copy House service", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();
  const request = validCopyHouseRequest("userA");

  request.serviceId = "unsupported_service";

  await assertFails(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("A user cannot change the initial request status", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();
  const requestRef = doc(db, "copyHouseRequests", "requestA");

  await assertSucceeds(
    setDoc(requestRef, validCopyHouseRequest("userA"))
  );

  await assertFails(
    updateDoc(requestRef, {
      status: "approved",
    })
  );
});

test("A user cannot read another user's Copy House request", async () => {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(
      doc(context.firestore(), "copyHouseRequests", "requestB"),
      validCopyHouseRequest("userB")
    );
  });

  const db = testEnv.authenticatedContext("userA").firestore();

  await assertFails(
    getDoc(doc(db, "copyHouseRequests", "requestB"))
  );
});

test("A user can list their own Copy House requests", async () => {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(
      doc(context.firestore(), "copyHouseRequests", "requestA"),
      validCopyHouseRequest("userA")
    );

    await setDoc(
      doc(context.firestore(), "copyHouseRequests", "requestB"),
      validCopyHouseRequest("userB")
    );
  });

  const db = testEnv.authenticatedContext("userA").firestore();

  const snapshot = await assertSucceeds(
    getDocs(
      query(
        collection(db, "copyHouseRequests"),
        where("submittedBy", "==", "userA")
      )
    )
  );

  if (snapshot.size !== 1 || snapshot.docs[0].id !== "requestA") {
    throw new Error("The query returned unexpected Copy House requests.");
  }
});

test("A user cannot delete their Copy House request", async () => {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(
      doc(context.firestore(), "copyHouseRequests", "requestA"),
      validCopyHouseRequest("userA")
    );
  });

  const db = testEnv.authenticatedContext("userA").firestore();

  await assertFails(
    deleteDoc(doc(db, "copyHouseRequests", "requestA"))
  );
});

// ============================================================
// ADDITIONAL COPY HOUSE COMPATIBILITY TESTS
// ============================================================

test("District Court Certified Copies request is accepted", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  const request = validCopyHouseRequest("userA");
  request.serviceId = "district_court_certified_copies";
  request.serviceSubtype = "";
  request.serviceDetails = {};

  await assertSucceeds(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("High Court Certified Copies request is accepted", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  const request = validCopyHouseRequest("userA");
  request.serviceId = "high_court_certified_copies";
  request.serviceSubtype = "";
  request.serviceDetails = {
    caseNumber: "123",
    caseYear: "2025",
    firstParty: "Party A",
    secondParty: "Party B",
    peshiType: "pucca",
    peshiDate: "2026-01-15",
    justices: ["Justice A"],
    district: "Lahore",
    requestedCopyDetails: ["Order copy"],
  };

  await assertSucceeds(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("Mutation Copies request is accepted", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  const request = validCopyHouseRequest("userA");
  request.serviceId = "mutation_copies";
  request.serviceSubtype = "";
  request.serviceDetails = {
    mutationNumber: "M-123",
    transactionDate: "2026-01-15",
    subRegistrarTown: "Lahore",
    district: "Lahore",
    tehsil: "Lahore City",
    villageMouza: "Example Mouza",
  };

  await assertSucceeds(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("Registered Gift Deed request is accepted", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  const request = validCopyHouseRequest("userA");
  request.serviceSubtype = "registered_gift_deed";

  await assertSucceeds(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("Registered General Power of Attorney request is accepted", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  const request = validCopyHouseRequest("userA");
  request.serviceSubtype = "registered_general_power_of_attorney";

  await assertSucceeds(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("Registered Special Power of Attorney request is accepted", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  const request = validCopyHouseRequest("userA");
  request.serviceSubtype = "registered_special_power_of_attorney";

  await assertSucceeds(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("High Court request rejects an invalid peshi type", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  const request = validCopyHouseRequest("userA");
  request.serviceId = "high_court_certified_copies";
  request.serviceSubtype = "";
  request.serviceDetails = {
    caseNumber: "123",
    caseYear: "2025",
    firstParty: "Party A",
    secondParty: "Party B",
    peshiType: "invalid_type",
    peshiDate: "2026-01-15",
    justices: ["Justice A"],
    district: "Lahore",
    requestedCopyDetails: ["Order copy"],
  };

  await assertFails(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("Copy House rejects an invalid registered-document subtype", async () => {
  const db = testEnv.authenticatedContext("userA").firestore();

  const request = validCopyHouseRequest("userA");
  request.serviceSubtype = "invalid_document_type";

  await assertFails(
    addDoc(collection(db, "copyHouseRequests"), request)
  );
});

test("My Requests query supports ownership filtering and newest-first sorting", async () => {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();

    await setDoc(doc(db, "copyHouseRequests", "olderRequest"), {
      ...validCopyHouseRequest("userA"),
      createdAt: new Date("2026-01-01T10:00:00Z"),
    });

    await setDoc(doc(db, "copyHouseRequests", "newerRequest"), {
      ...validCopyHouseRequest("userA"),
      createdAt: new Date("2026-02-01T10:00:00Z"),
    });

    await setDoc(doc(db, "copyHouseRequests", "otherUserRequest"), {
      ...validCopyHouseRequest("userB"),
      createdAt: new Date("2026-03-01T10:00:00Z"),
    });
  });

  const db = testEnv.authenticatedContext("userA").firestore();

  const snapshot = await assertSucceeds(
    getDocs(
      query(
        collection(db, "copyHouseRequests"),
        where("submittedBy", "==", "userA"),
        orderBy("createdAt", "desc")
      )
    )
  );

  const returnedIds = snapshot.docs.map((document) => document.id);

  if (
    snapshot.size !== 2 ||
    returnedIds[0] !== "newerRequest" ||
    returnedIds[1] !== "olderRequest"
  ) {
    throw new Error(
      `Unexpected My Requests results or order: ${returnedIds.join(", ")}`
    );
  }
});