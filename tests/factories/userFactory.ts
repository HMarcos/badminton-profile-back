import { faker } from '@faker-js/faker';
import prismaClient from '../../src/config/database.js';

import { SignUpData } from '../../src/types/userType.js';
import encryptionUtils from '../../src/utils/encryptionUtils.js';

function createSignUpInfo() {
  const signUpData: SignUpData = {
    email: faker.internet.email(),
    password: faker.internet.password(),
    get passwordConfirmation() {
      return this.password;
    },
  };

  return signUpData;
}

async function registerUser() {
  const signUpData = createSignUpInfo();
  const userData = { email: signUpData.email, password: encryptionUtils.encryptWithBcrypt(signUpData.password) };
  const user = await prismaClient.user.create({ data: userData });
  const userInfo = {...user, password: signUpData.password}
  return userInfo;
}

const userFactory = {
  createSignUpInfo,
  registerUser,
};

export default userFactory;
