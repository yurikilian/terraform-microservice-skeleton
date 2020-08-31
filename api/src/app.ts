import express, { Request, Response } from "express";

const app = express();

app.get("/", (req: Request, res: Response) => {
  res.send("hello");
});
app.get("/healthcheck", (req, res) => {
  res.send("UP").status(200);
});

const PORT = 3000;

app.listen(PORT, () => console.log(`Server Running on port ${PORT}`));
