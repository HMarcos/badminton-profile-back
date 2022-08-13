-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('Masculino', 'Feminino');

-- CreateEnum
CREATE TYPE "Laterality" AS ENUM ('Destro', 'Canhoto');

-- CreateEnum
CREATE TYPE "Result" AS ENUM ('R64', 'R32', 'R16', 'QF', 'SF', 'F', 'C');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "category" TEXT NOT NULL,
    "type" "Gender" NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "athletes" (
    "id" SERIAL NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "height" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,
    "photoPath" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "birthDate" DATE NOT NULL,
    "birthPlace" TEXT NOT NULL,
    "laterality" "Laterality" NOT NULL,
    "categoryId" INTEGER NOT NULL,

    CONSTRAINT "athletes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "umpires" (
    "id" SERIAL NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "height" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,
    "photoPath" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "birthDate" DATE NOT NULL,
    "birthPlace" TEXT NOT NULL,
    "profession" TEXT NOT NULL,
    "formation" TEXT NOT NULL,

    CONSTRAINT "umpires_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "athletes_results" (
    "id" SERIAL NOT NULL,
    "tounament" TEXT NOT NULL,
    "result" "Result" NOT NULL,
    "modality" TEXT NOT NULL,
    "startDate" DATE NOT NULL,
    "endDate" DATE NOT NULL,
    "athleteId" INTEGER NOT NULL,

    CONSTRAINT "athletes_results_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "umpire_participations" (
    "id" SERIAL NOT NULL,
    "tounament" TEXT NOT NULL,
    "umpiredMatches" INTEGER NOT NULL,
    "referee" BOOLEAN NOT NULL,
    "startDate" DATE NOT NULL,
    "endDate" DATE NOT NULL,
    "umpireId" INTEGER NOT NULL,

    CONSTRAINT "umpire_participations_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "categories_category_type_key" ON "categories"("category", "type");

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "athletes" ADD CONSTRAINT "athletes_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "athletes_results" ADD CONSTRAINT "athletes_results_athleteId_fkey" FOREIGN KEY ("athleteId") REFERENCES "athletes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "umpire_participations" ADD CONSTRAINT "umpire_participations_umpireId_fkey" FOREIGN KEY ("umpireId") REFERENCES "umpires"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
