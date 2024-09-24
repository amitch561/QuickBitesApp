CREATE TABLE "Delivers_To" (
  "OrderID" INT,
  "DriverID" INT,
  "CustomerID" INT,
  "PickUpTime" TIMESTAMP,
  "DeliveryStatus" VARCHAR(50),
  "DeliveryAddress" VARCHAR(255),
  "DeliveryTime" TIMESTAMP,
  "CurrentLocation" VARCHAR(255),
  PRIMARY KEY ("OrderID", "DriverID", "CustomerID")
);

CREATE INDEX "Idx_Delivers_To" ON "Delivers_To" ("PickUpTime", "DeliveryStatus", "DeliveryAddress", "DeliveryTime", "CurrentLocation");

CREATE TABLE "MenuItem" (
  "RestaurantID" INT,
  "MenuItemID" SERIAL,
  "MealName" VARCHAR(100),
  "Price" DECIMAL(5,2),
  PRIMARY KEY ("RestaurantID", "MenuItemID")
);

CREATE INDEX "Idx_MenuItem" ON "MenuItem" ("MealName", "Price");

CREATE TABLE "Driver" (
  "DriverID" SERIAL,
  "dName" VARCHAR(100),
  "dPhoneNumber" VARCHAR(13),
  "DriverRating" VARCHAR(100),
  PRIMARY KEY ("DriverID")
);

CREATE INDEX "Idx_Driver" ON "Driver" ("dName", "dPhoneNumber", "DriverRating");

CREATE TABLE "Restaurant" (
  "RestaurantID" SERIAL,
  "rAddress" VARCHAR(100),
  "RestaurantName" VARCHAR(200),
  "rPhoneNumber" VARCHAR(13),
  PRIMARY KEY ("RestaurantID")
);

CREATE INDEX "Idx_Restaurant" ON "Restaurant" ("rAddress", "RestaurantName", "rPhoneNumber");

CREATE TABLE "prepares" (
  "MenuItemID" INT,
  "RestaurantID" INT,
  "special_instructions" VARCHAR(200),
  PRIMARY KEY ("MenuItemID", "RestaurantID"),
  CONSTRAINT "FK_prepares_RestaurantID"
    FOREIGN KEY ("RestaurantID")
      REFERENCES "Restaurant"("RestaurantID")
);

CREATE INDEX "Idx_prepares" ON "prepares" ("special_instructions");

CREATE TABLE "Customer" (
  "CustomerID" SERIAL,
  "cEmail" VARCHAR(100),
  "cName" VARCHAR(100),
  "cPhoneNumber" VARCHAR(13),
  "cAddress" VARCHAR(255),
  "cPassword" VARCHAR(100),
  "PaymentMethod" VARCHAR(100),
  PRIMARY KEY ("CustomerID")
);

CREATE INDEX "Idx_Customer" ON "Customer" ("cEmail", "cName", "cPhoneNumber", "cAddress", "cPassword", "PaymentMethod");

CREATE TABLE "Orders_From" (
  "DriverID" INT,
  "OrderID" SERIAL,
  "CustomerID" INT,
  "RestaurantID" INT,
  "MenuItemID" INT,
  "OrderDate" TIMESTAMP,
  "TotalAmount" DECIMAL(7,2),
  "Status" VARCHAR(50),
  PRIMARY KEY ("DriverID", "OrderID", "CustomerID", "RestaurantID", "MenuItemID"),
  CONSTRAINT "FK_Orders_From_RestaurantID"
    FOREIGN KEY ("RestaurantID")
      REFERENCES "Restaurant"("RestaurantID"),
  CONSTRAINT "FK_Orders_From_CustomerID"
    FOREIGN KEY ("CustomerID")
      REFERENCES "Customer"("CustomerID")
);

CREATE INDEX "Idx_Orders_From" ON "Orders_From" ("OrderDate", "TotalAmount", "Status");
