// Imports the Google Cloud client library.
import { Storage, UploadResponse } from "@google-cloud/storage";
// import keyFile from "../../grocery-inventory.json";

const projectId = "grocery-inventory";
const keyFilename = "grocery-inventory.json";
const storage = new Storage({ projectId, keyFilename });

// Makes an authenticated API request.
async function uploadToBucket(file: string): Promise<any> {
  try {
    const bucket = await storage.bucket("grocery-inventory");
    const result: UploadResponse = await bucket.upload(file);
    const name = result[0].metadata.name;
    const url = `https://storage.googleapis.com/grocery-inventory/${name}`;
    return url;
  } catch (err) {
    console.error("ERROR:", err);
  }
}

export default uploadToBucket;
