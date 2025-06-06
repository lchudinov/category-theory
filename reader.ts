class Reader<R, A> {
  constructor(
    public readonly run: (env: R) => A
  ) {

  }

  map<B>(f: (a: A) => B): Reader<R, B> {
    return new Reader((env: R) => f(this.run(env)));
  }
}

type Config = { port: number };

const getPort = new Reader((config: Config) => config.port);

const addOffset = getPort.map(port => port + 1000);

const result = addOffset.run({ port: 3000 }); // => 4000
console.log(result); // 4000
