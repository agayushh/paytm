-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "accountNum" INTEGER NOT NULL,
    "bankName" TEXT NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "TransactionId" SERIAL NOT NULL,
    "SenderId" INTEGER NOT NULL,
    "ReceieverId" INTEGER NOT NULL,
    "Amount" INTEGER NOT NULL,
    "TransactionTime" TIMESTAMP(3) NOT NULL,
    "TransactionStatus" TEXT NOT NULL,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("TransactionId")
);

-- CreateTable
CREATE TABLE "account_details" (
    "AccountHolderName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "AccountNumber" INTEGER NOT NULL,
    "BankName" TEXT NOT NULL,
    "BankBranch" TEXT NOT NULL,
    "IFSCCode" TEXT NOT NULL,
    "AccountType" TEXT NOT NULL,
    "Amount" INTEGER NOT NULL,

    CONSTRAINT "account_details_pkey" PRIMARY KEY ("AccountNumber")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_id_key" ON "users"("id");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_accountNum_key" ON "users"("accountNum");

-- CreateIndex
CREATE UNIQUE INDEX "account_details_email_key" ON "account_details"("email");

-- CreateIndex
CREATE UNIQUE INDEX "account_details_AccountNumber_key" ON "account_details"("AccountNumber");

-- CreateIndex
CREATE UNIQUE INDEX "account_details_IFSCCode_key" ON "account_details"("IFSCCode");

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_SenderId_fkey" FOREIGN KEY ("SenderId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_ReceieverId_fkey" FOREIGN KEY ("ReceieverId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account_details" ADD CONSTRAINT "account_details_AccountNumber_fkey" FOREIGN KEY ("AccountNumber") REFERENCES "users"("accountNum") ON DELETE RESTRICT ON UPDATE CASCADE;
