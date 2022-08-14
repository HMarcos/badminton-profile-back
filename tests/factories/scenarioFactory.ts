import prismaClient from '../../src/config/database.js';
import userFactory from './userFactory.js';

async function deleteAllData() {
  await prismaClient.$transaction([
    prismaClient.$executeRaw`TRUNCATE TABLE users CASCADE`,
    prismaClient.$executeRaw`TRUNCATE TABLE sessions`,
    prismaClient.$executeRaw`TRUNCATE TABLE categories CASCADE`,
    prismaClient.$executeRaw`TRUNCATE TABLE athletes CASCADE`,
    prismaClient.$executeRaw`TRUNCATE TABLE umpires CASCADE`,
    prismaClient.$executeRaw`TRUNCATE TABLE athletes_results`,
    prismaClient.$executeRaw`TRUNCATE TABLE umpire_participations`,
  ]);
}

async function createScenarioWithUser() {
  const user = await userFactory.registerUser();
  return user;
}

const scenarioFactory = {
  deleteAllData,
  createScenarioWithUser,
};

export default scenarioFactory;
