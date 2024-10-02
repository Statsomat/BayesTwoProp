

### Hi Students!

If you need to access a private GitHub repository shared with you through Posit Cloud, follow these simple steps to create a Personal Access Token (PAT) and use it to authenticate.

#### **Step 1: Generate a Personal Access Token (PAT) on GitHub**
1. **Log in** to your GitHub account.
2. Click on your profile picture (top right corner) and go to **"Settings"**.
3. On the left sidebar, scroll down and select **"Developer settings"**.
4. Click **"Personal access tokens"** > **"Tokens (classic)"**.
5. Click the **"Generate new token"** button.
6. Give your token a **name**, like `Posit Cloud Access`.
7. Set an **expiration date** (e.g., 30 days, 90 days, or longer).
8. Under **"Select scopes"**, check the box next to **`repo`**. This will give you the required permissions for private repositories.
9. Scroll down and click **"Generate token"**.
10. Copy the token value shown on the screen — this is your **Personal Access Token**. You’ll only see it **once**, so make sure to copy it somewhere safe!

#### **Step 2: Use the Personal Access Token in Posit Cloud**
1. **Open Posit Cloud** and go to your project.
2. Select **"New Project"** and choose **"New Project from Git Repository"**.
3. Enter the URL of the private repository (e.g., `https://github.com/your-instructor/repo-name`).
4. Posit Cloud will prompt you for your **GitHub username** and **password**.
   - Use your **GitHub username** as usual.
   - Instead of your GitHub **password**, **paste the Personal Access Token** you copied earlier as the password.
5. Click **"Create Project"**.
6. If the token is correct and you have been added as a collaborator, you should now see the private repository’s contents in your Posit Cloud project!

#### **Quick Tips:**
- If the **token expires**, or you lose it, you can always generate a new one by following the same steps.
- Make sure you’ve been added as a **collaborator** to the private repository. Otherwise, you won’t be able to access it, even with the token.

Let me know if you have any questions or need help!
ChatGPT
