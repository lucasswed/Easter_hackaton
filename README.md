# 42 Portfolio Generator

## Description

A terminal-basaed automated portfolio generator for 42 students to list their projects and progression of the cursus!

## Start using

Only tested on linux

### Requirements

  - git - ruby - gem - bundle

### Step 0:

Clone this repository to your machine and go to the root of the folder
```bash
git clone https://github.com/lucasswed/Easter_hackaton/ 42-portfolio ; cd 42-portfolio
```

### Step 1:
<p>The resource server (intra) is not a public network, only people with access are allowed to peek into students profile,
therefore you will need an access key using the oauth system, but dont worry its not that hard!</p>

<p>Here is some links in case you want to learn more about the api</p>

<https://api.intra.42.fr/apidoc>

<https://pulgamecanica.herokuapp.com/posts/42api-projects>

#### Shortcut

- Using your prefered browser, login with your credentials at the intra website
- Go to <strong>Settings</strong> -> <strong>API</strong> -> <strong>Register a new app</strong>
- Fill in the form - <strong>Important notes</strong>:
  - No need to make your app public
  - Provide a valid redirect uri (ex: 'www.google.com')
  - <strong>DO NOT CHANGE THE SCOPE</strong>: Acessing the user public data will be enough
  - The rest of mandatory fields are irrelevant
- After sucessfully submitting the form you should now have access to a uid and secret tokens

<strong>
⚠ 
Anyone with your credentials will be able to access intra as long as they are valid, for security reasons DO NOT share them or put them on a git repository!!
</strong>

### Step 2:
  - You should have your terminal open at the root of the repository
  - The application will need your generated credentials, you can provide them by replacing the .env.sample file
   with a .env file and filling in the variables values. If you haven't used .env files before feel free to skip
   this step as you will be prompted to insert all missing values.
  - Install dependencies
  ``` bash
    bundle install
  ```
  PS: If this failed due to permissions, you may run ``export GEM_HOME=<INSERT DIR>`` to an existing and valid directory and then rerun the previous command
  - Run the program
  ``` bash
    ./intra_portfolio_generator
  ```
### Step 3:
  - If everything went as expected, your files should be under the output folder ( ${name}.json and ${name}.html ), you may now use these files as you wish.
  - <strong>Ideas</strong>
    - Add it to your personal website
    - Create a github page

## Features

- ✅ Retrieve users data from 42 intra
- ✅ Generate a html file
- ☐ Make the html file responsive (mobile devices) and exportable as pdf
- ☐ Allow cursus/projects selection
- ☐ Minimal Ui for customization (colors, size, etc..)
- ☐ Dynamic github projects links
- ☐ Find a solution so users dont have to generate their own api key
