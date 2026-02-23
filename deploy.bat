@echo off
echo Deploying Simple Web App to GitHub...
git add index.html
git commit -m "Switch to standalone HTML for better iOS support"
git push origin main -f
echo Done! Your site should update in a minute.