# Deploy the blog & upload source codes conveniently.

# Upload source codes.
git add .
git commit -m "TinkerRobot: Upload source codes."
git push origin hexo

# Deploy the blog.
hexo clean
hexo generate
hexo deploy

# Done.
echo "> Uploading & Deployment COMPLETED."
