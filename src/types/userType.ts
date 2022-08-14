import { User } from '@prisma/client';

export type UserCreationData = Omit<User, 'id'>;
export type LoginData = Omit<User, 'id'>;

export type SignUpData = UserCreationData & {
  passwordConfirmation: string;
};
