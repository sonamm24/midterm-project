/*
 * All routes for Users are defined here
 * Since this file is loaded in server.js into api/users,
 *   these routes are mounted onto /users
 * See: https://expressjs.com/en/guide/using-middleware.html#middleware.router
 */
const express = require('express');
const router = express.Router();

module.exports = (db) => {
  //displays all the publicly available quizzes
  router.get("/", (req, res) => {
    //const user_id = req.session.user_id;
    db.getQuizzes(10)
      .then(data => {
        const templateVars = {
          //user_id,
          quizzes: data
        };
        res.render("view_quizzes", templateVars);
      })
      .catch(err => {
        res
          .status(500)
          .json({ error: err.message });
      });
  });

  //loads a quiz to be taken by any user/guest
  router.get("/:quiz_id", (req, res) => {
    
    db.getQuizWithQuizId(req.params.quiz_id)
      .then(result => {
        res.render("start_quiz", {quizData: result});
      })
      .catch(err => {
        console.log("query failed: ", err.stack);
        res.statusCode = 404;
        res.render("error", {error: "couldn't retrieve quiz"});
      });
  });
  return router;
};