import joi from "joi";
import { LoginData } from "../types/userType";

const signInSchema = joi.object<LoginData>({
    email: joi.string().email().required(),
    password: joi.string().required()
});

export default signInSchema;
