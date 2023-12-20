CREATE MIGRATION m1froyon7b62yobz7onhxaq5isoer5r5b7znwfstdl3ohwt55oqm3q
    ONTO initial
{
  CREATE TYPE default::Ball {
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::BallFormat {
      CREATE REQUIRED PROPERTY name: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
  };
  ALTER TYPE default::Ball {
      CREATE REQUIRED LINK format: default::BallFormat;
      CREATE CONSTRAINT std::exclusive ON ((.name, .format));
  };
  ALTER TYPE default::BallFormat {
      CREATE LINK balls := (.<format[IS default::Ball]);
  };
  CREATE TYPE default::BallGame {
      CREATE REQUIRED LINK theirBall: default::Ball;
      CREATE REQUIRED LINK yourBall: default::Ball;
      CREATE REQUIRED LINK format: default::BallFormat;
      CREATE REQUIRED PROPERTY losses: std::int64;
      CREATE REQUIRED PROPERTY wins: std::int64;
  };
  ALTER TYPE default::BallFormat {
      CREATE LINK games := (.<format[IS default::BallGame]);
  };
};
