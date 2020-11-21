// Imports the Google Cloud client library.
import { Storage } from "@google-cloud/storage";
// import keyFile from "../../grocery-inventory.json";

const projectId = "grocery-inventory";
const keyFilename = "grocery-inventory.json";
const storage = new Storage({ projectId, keyFilename });

// Makes an authenticated API request.
async function listBuckets() {
  try {
    const [buckets] = await storage.getBuckets();

    console.log("Buckets:");
    buckets.forEach((bucket) => {
      console.log(bucket.name);
    });
  } catch (err) {
    console.error("ERROR:", err);
  }
}

export default listBuckets;
