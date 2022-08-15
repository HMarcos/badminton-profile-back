import { Session } from "@prisma/client";

export type SessionCreationData = Omit<Session, "id">;