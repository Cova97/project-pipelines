-- CreateTable
CREATE TABLE "public"."Book" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "published" TIMESTAMP(3) NOT NULL,
    "isbn" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Book_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."_BookCategories" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_BookCategories_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "Book_isbn_key" ON "public"."Book"("isbn");

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "public"."Category"("name");

-- CreateIndex
CREATE INDEX "_BookCategories_B_index" ON "public"."_BookCategories"("B");

-- AddForeignKey
ALTER TABLE "public"."_BookCategories" ADD CONSTRAINT "_BookCategories_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."Book"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."_BookCategories" ADD CONSTRAINT "_BookCategories_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;
