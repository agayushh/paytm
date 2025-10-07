/*
  Warnings:

  - The primary key for the `account_details` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `AccountHolderName` on the `account_details` table. All the data in the column will be lost.
  - You are about to drop the column `AccountNumber` on the `account_details` table. All the data in the column will be lost.
  - You are about to drop the column `AccountType` on the `account_details` table. All the data in the column will be lost.
  - You are about to drop the column `Amount` on the `account_details` table. All the data in the column will be lost.
  - You are about to drop the column `BankBranch` on the `account_details` table. All the data in the column will be lost.
  - You are about to drop the column `BankName` on the `account_details` table. All the data in the column will be lost.
  - You are about to drop the column `IFSCCode` on the `account_details` table. All the data in the column will be lost.
  - The primary key for the `transactions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Amount` on the `transactions` table. All the data in the column will be lost.
  - You are about to drop the column `ReceieverId` on the `transactions` table. All the data in the column will be lost.
  - You are about to drop the column `SenderId` on the `transactions` table. All the data in the column will be lost.
  - You are about to drop the column `TransactionId` on the `transactions` table. All the data in the column will be lost.
  - You are about to drop the column `TransactionStatus` on the `transactions` table. All the data in the column will be lost.
  - You are about to drop the column `TransactionTime` on the `transactions` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[ifscCode]` on the table `account_details` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `accountHolderName` to the `account_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `accountNumber` to the `account_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `accountType` to the `account_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `amount` to the `account_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bankBranch` to the `account_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bankName` to the `account_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ifscCode` to the `account_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `amount` to the `transactions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `receiverId` to the `transactions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `senderId` to the `transactions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `transactionStatus` to the `transactions` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."account_details" DROP CONSTRAINT "account_details_AccountNumber_fkey";

-- DropForeignKey
ALTER TABLE "public"."transactions" DROP CONSTRAINT "transactions_ReceieverId_fkey";

-- DropForeignKey
ALTER TABLE "public"."transactions" DROP CONSTRAINT "transactions_SenderId_fkey";

-- DropIndex
DROP INDEX "public"."account_details_AccountNumber_key";

-- DropIndex
DROP INDEX "public"."account_details_IFSCCode_key";

-- AlterTable
ALTER TABLE "account_details" DROP CONSTRAINT "account_details_pkey",
DROP COLUMN "AccountHolderName",
DROP COLUMN "AccountNumber",
DROP COLUMN "AccountType",
DROP COLUMN "Amount",
DROP COLUMN "BankBranch",
DROP COLUMN "BankName",
DROP COLUMN "IFSCCode",
ADD COLUMN     "accountHolderName" TEXT NOT NULL,
ADD COLUMN     "accountNumber" INTEGER NOT NULL,
ADD COLUMN     "accountType" TEXT NOT NULL,
ADD COLUMN     "amount" INTEGER NOT NULL,
ADD COLUMN     "bankBranch" TEXT NOT NULL,
ADD COLUMN     "bankName" TEXT NOT NULL,
ADD COLUMN     "ifscCode" TEXT NOT NULL,
ADD CONSTRAINT "account_details_pkey" PRIMARY KEY ("accountNumber");

-- AlterTable
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_pkey",
DROP COLUMN "Amount",
DROP COLUMN "ReceieverId",
DROP COLUMN "SenderId",
DROP COLUMN "TransactionId",
DROP COLUMN "TransactionStatus",
DROP COLUMN "TransactionTime",
ADD COLUMN     "amount" INTEGER NOT NULL,
ADD COLUMN     "receiverId" INTEGER NOT NULL,
ADD COLUMN     "senderId" INTEGER NOT NULL,
ADD COLUMN     "transactionId" SERIAL NOT NULL,
ADD COLUMN     "transactionStatus" TEXT NOT NULL,
ADD COLUMN     "transactionTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT "transactions_pkey" PRIMARY KEY ("transactionId");

-- CreateIndex
CREATE UNIQUE INDEX "account_details_ifscCode_key" ON "account_details"("ifscCode");

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account_details" ADD CONSTRAINT "account_details_accountNumber_fkey" FOREIGN KEY ("accountNumber") REFERENCES "users"("accountNum") ON DELETE RESTRICT ON UPDATE CASCADE;
