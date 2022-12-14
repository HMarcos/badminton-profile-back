import { Router } from 'express';
import { signUp, signIn } from '../controllers/authController.js';
import validateSchema from '../middlewares/validateSchemaMiddleware.js';
import signInSchema from '../schemas/signInSchema.js';
import signUpSchema from '../schemas/signUpSchema.js';

const authRouter = Router();

authRouter.post('/sign-up', validateSchema(signUpSchema), signUp);
authRouter.post('/sign-in', validateSchema(signInSchema), signIn);

export default authRouter;
