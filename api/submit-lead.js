// /api/submit-lead.js
export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { email, features, feedback } = req.body;

  const airtableToken = process.env.AIRTABLE_PAT;
  const baseId = 'appOzpDcRKHF7cp4i';
  const tableName = 'Leads';

  try {
    const airtableRes = await fetch(`https://api.airtable.com/v0/${baseId}/${tableName}`, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${airtableToken}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        records: [
          {
            fields: {
              Email: email,
              RequestedFeatures: features,
              Feedback: feedback
            }
          }
        ]
      })
    });

    const data = await airtableRes.json();

    if (!airtableRes.ok) {
      return res.status(airtableRes.status).json({ error: data?.error?.message || 'Failed to submit to Airtable' });
    }

    return res.status(200).json({ success: true });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

