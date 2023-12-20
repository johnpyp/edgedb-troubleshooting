import { createClient } from "edgedb";
import e from "../dbschema/edgeql-js";

const client = createClient();

const ballFormat = e
  .insert(e.BallFormat, {
    name: "Ball Format 1",
  })
  .unlessConflict((bf) => ({ on: bf.name, else: bf }));

const yourBall = e
  .insert(e.Ball, {
    name: "Soccerball",
    format: ballFormat,
  })
  .unlessConflict((b) => ({ on: e.tuple([b.name, b.format]), else: b }));

const theirBall = e
  .insert(e.Ball, {
    name: "Basketball",
    format: ballFormat,
  })
  .unlessConflict((b) => ({ on: e.tuple([b.name, b.format]), else: b }));

const ballGame = e.insert(e.BallGame, {
  theirBall: theirBall,
  yourBall: yourBall,
  format: ballFormat,
  losses: 2,
  wins: 0,
});

const query = e.select(ballGame, (b) => ({
  id: true,
  theirBall: true,
  format: true,
}));

console.log(query.toEdgeQL());

const res = await query.run(client);

console.log(res);
