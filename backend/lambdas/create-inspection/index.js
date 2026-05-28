const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");
const crypto = require("crypto");

const client = new DynamoDBClient({});
const dynamodb = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
  try {
    const body = JSON.parse(event.body || "{}");

    const inspection = {
      inspection_id: crypto.randomUUID(),
      customer_name: body.customer_name || "Unknown Customer",
      property_address: body.property_address || "Unknown Address",
      status: "CREATED",
      created_at: new Date().toISOString()
    };

    await dynamodb.send(
      new PutCommand({
        TableName: process.env.TABLE_NAME,
        Item: inspection
      })
    );

    return {
      statusCode: 201,
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        message: "Inspection created successfully",
        inspection
      })
    };
  } catch (error) {
    return {
      statusCode: 500,
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        message: "Failed to create inspection",
        error: error.message
      })
    };
  }
};