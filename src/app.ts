import express, { json } from 'express';
import 'express-async-errors';
import cors from 'cors';
import handleErrors from './middlewares/handleErrorsMiddleware.js';

const app = express();
app.use(cors());
app.use(json());
app.use(handleErrors);

export default app;
