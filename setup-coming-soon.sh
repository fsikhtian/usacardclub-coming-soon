# Navigate to your projects folder
cd ~/Projects

# 1. Create the project directory and enter it
echo "Creating project directory..."
mkdir -p usacardclub-coming-soon && cd usacardclub-coming-soon

# 2. Create a simple Coming Soon HTML page
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>USACardClub — Coming Soon</title>
  <style>
    body { 
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
      font-family: sans-serif;
      background: #00255A;
      color: #fff;
      text-align: center;
    }
    a { color: #F44336; text-decoration: none; }
  </style>
</head>
<body>
  <div>
    <h1>USACardClub</h1>
    <p>Prepaid U.S. Visa cards—launching soon.</p>
    <p><a href="https://tally.so/r/your-pre-registration-form">Pre-register your interest</a></p>
  </div>
</body>
</html>
EOF

# 3. Initialize Git, commit, and push

echo "Initializing Git repository..."
git init

echo "Committing Coming Soon page..."
git add index.html

# If you have the GitHub CLI installed, you can create and push in one step:
if command -v gh &> /dev/null; then
  echo "Creating GitHub repo via gh CLI and pushing..."
  gh repo create fsikhtian/usacardclub-coming-soon \
    --public \
    --source=. \
    --remote=origin \
    --push
else
  # Otherwise add remote manually and push:
  git commit -m "Add Coming Soon page"
  echo "Adding remote and pushing to GitHub..."
  git remote add origin git@github.com:fsikhtian/usacardclub-coming-soon.git
  git push -u origin main
fi

echo "🎉 Coming Soon page setup complete. Visit https://usacardclub.com once DNS is configured!"
