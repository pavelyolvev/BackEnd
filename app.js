var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const session = require('express-session');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var loginRouter = require('./routes/login');
var clientRouter = require('./routes/client');
var resultRouter = require('./routes/result');
var apiRouter = require('./routes/api');

var app = express();

app.use(session({
  secret: 'Go3jt54ldf', // Храни в .env
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // true, если HTTPS
}));
// Настройка EJS
app.set('views', path.join(__dirname, '../FrontEnd/views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, '../FrontEnd/public')));

// Маршруты
app.use('/', loginRouter);
app.use('/login', loginRouter);
app.use('/users', usersRouter);
app.use('/client', clientRouter);
app.use('/api', apiRouter);
app.use('/client/:id/:calculationId/:structure/result', resultRouter);

// Обработка ошибок

app.use(function(req, res, next) {
  next(createError(404));
});
app.use(function(err, req, res, next) {
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  res.status(err.status || 500);
  res.render('error', { error: err, message: err.message, statusCode: err.status});
});



module.exports = app;