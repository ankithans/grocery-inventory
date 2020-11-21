import vision from "@google-cloud/vision";

async function googleVision(image: string) {
  // Creates a client
  const projectId = "grocery-inventory";
  const keyFilename = "grocery-inventory.json";
  const client = new vision.ImageAnnotatorClient({ projectId, keyFilename });

  // Performs label detection on the image file
  const [result] = await client.labelDetection(image);

  //   const labels = result.labelAnnotations;
  console.log("Labels:");
  //   if (labels != null) labels.forEach((label) => console.log(label.description));
  return result;
}

export default googleVision;
