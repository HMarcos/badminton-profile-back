import supertest from 'supertest';

import app from '../../src/app.js';
import scenarioFactory from '../factories/scenarioFactory.js';
import userFactory from '../factories/userFactory.js';
import userRepository from '../../src/repositories/userRepository.js';

beforeEach(async () => {
  await scenarioFactory.deleteAllData();
});

const agent = supertest(app);

describe('Sign up test suite', () => {
  it('Create a valid user', async () => {
    const signUpData = userFactory.createSignUpInfo();
    const response = await agent.post('/sign-up').send(signUpData);
    expect(response.status).toBe(201);

    const newUser = await userRepository.findByEmail(signUpData.email);
    expect(newUser).not.toBeNull();
  });

  it('Send a user with empty body - Error 422', async () => {
    const response = await agent.post('/sign-up').send({});
    expect(response.status).toBe(422);
  });

  it('Send a user with invalid passwordConfirmation - Error 422', async () => {
    let signUpData = userFactory.createSignUpInfo();
    signUpData = { ...signUpData, passwordConfirmation: 'senhaAleatoria' };
    const response = await agent.post('/sign-up').send(signUpData);
    expect(response.status).toBe(422);
  });

  it('Submit an existing user - Error 409', async () => {
    const user = await scenarioFactory.createScenarioWithUser();
    const signUpData = { email: user.email, password: 'senha', passwordConfirmation: 'senha' };

    const response = await agent.post('/sign-up').send(signUpData);
    expect(response.status).toBe(409);
  });
});
