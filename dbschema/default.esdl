module default {
  type BallGame {
    required yourBall: Ball;
    required theirBall: Ball;
    required wins: int64;
    required losses: int64;
    required format: BallFormat;

  }

  type BallFormat {
    required name: str {
      constraint exclusive;
    };

    games := .<format[is BallGame];
    balls := .<format[is Ball];

  }

  type Ball {
    required name: str;
    required format: BallFormat;

    
    constraint exclusive on ( (.name, .format) );
  }
}
