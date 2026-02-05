const { onRequest } = require("firebase-functions/v2/https");
const { logger } = require("firebase-functions");
const { Resend } = require("resend");

// Initialize Resend with Secret Manager (Best Practice for 2026)
const resend = new Resend(process.env.RESEND_API_KEY);

exports.subscribeToNewsletter = onRequest({ cors: true }, async (req, res) => {
  const { email, firstName } = req.body;

  if (!email) {
    return res.status(400).send({ error: "Email is required" });
  }

  try {
    const data = await resend.emails.send({
      from: 'Publisher <newsletter@yourdomain.com>',
      to: [email],
      subject: 'Welcome to the Newsletter!',
      html: `<strong>Hi ${firstName || 'Reader'},</strong><p>Thanks for subscribing!</p>`
    });

    logger.info("Email sent successfully", { email });
    return res.status(200).send({ message: "Subscription successful", id: data.id });
  } catch (error) {
    logger.error("Resend Error", error);
    return res.status(500).send({ error: "Failed to send email" });
  }
});
