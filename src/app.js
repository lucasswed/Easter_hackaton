import * as dotenv from "dotenv";
dotenv.config({ path: '../.env' });

import express from "express";
import passport from "passport";
import OAuth2Strategy from "passport-oauth2";

const app = express();
const port = 3000;

passport.use(new OAuth2Strategy({
    authorizationURL: 'https://api.intra.42.fr/oauth/authorize',
    tokenURL: 'https://api.intra.42.fr/oauth/token',
    clientID: process.env.UID,
    clientSecret: process.env.SECRET,
    callbackURL: "http://localhost:3000/auth/callback"
  },
  function(accessToken, refreshToken, profile, cb) {
    console.log("access_token=", accessToken);
    //console.log(refreshToken);
   // console.log(profile);
    // User.findOrCreate({ exampleId: profile.id }, function (err, user) {
    //   return cb(err, user);
    // });
    return cb();
  }
));

app.get('/', function (req, res) {
  console.log('here');
})

app.get('/auth', passport.authenticate('oauth2'));

app.get('/auth/callback',
  passport.authenticate('oauth2', { successRedirect: '/success', failureRedirect: '/failure' }),
  function(req, res) {
    console.log("response: ", res);
    res.redirect('/');
  }
)

app.listen(port, () => {
  console.log(`listening on port ${port}`)
})
