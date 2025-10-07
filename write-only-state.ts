// Тип Writer: просто объект с результатом и логом
type Writer<W, A> = {
  value: A
  log: W
}

function writer<W, A>(value: A, log: W): Writer<W, A> {
  return { value, log }
}

function runWriter<W, A>(w: Writer<W, A>): [A, W] {
  return [w.value, w.log]
}

function fmap<W, A, B>(f: (a: A) => B, w: Writer<W, A>): Writer<W, B> {
  return writer(f(w.value), w.log)
}

function pure<W>(mempty: W) {
  return function <A>(a: A): Writer<W, A> {
    return writer(a, mempty)
  }
}

function apply<W>(
  mappend: (w1: W, w2: W) => W,
  wf: Writer<W, (a: any) => any>,
  wa: Writer<W, any>
): Writer<W, any> {
  return writer(wf.value(wa.value), mappend(wf.log, wa.log))
}

function bind<W, A, B>(
  mappend: (w1: W, w2: W) => W,
  wa: Writer<W, A>,
  k: (a: A) => Writer<W, B>
): Writer<W, B> {
  const wb = k(wa.value)
  return writer(wb.value, mappend(wa.log, wb.log))
}

function tell<W>(msg: W, mempty: W): Writer<W, void> {
  return writer(undefined, msg)
}

const mempty: string[] = []
const mappend = (w1: string[], w2: string[]) => w1.concat(w2)

function add(x: number, y: number): Writer<string[], number> {
  return writer(x + y, [`Adding ${x} and ${y}`])
}

function mul(x: number, y: number): Writer<string[], number> {
  return writer(x * y, [`Multiplying ${x} and ${y}`])
}

function calc(): Writer<string[], number> {
  return bind(mappend, add(2, 3), a =>
    bind(mappend, mul(a, 4), b =>
      bind(mappend, mul(b, b), c => 
        pure<string[]>(mempty)(c)
      )
    )
  )
}

function main() {
  const [result, log] = runWriter(calc())
  console.log("Result:", result)
  console.log("Log:")
  log.forEach(line => console.log(line))
}

main()
