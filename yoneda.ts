// Функтор: что-то, что умеет fmap/map
interface Functor<F> {
  map: <A, B>(fa: F & { value: A }, f: (a: A) => B) => F & { value: B }
}

// Yoneda-обёртка
type Yoneda<F, A> = {
  runYoneda: <B>(f: (a: A) => B) => F & { value: B }
}

// Преобразование F<A> → Yoneda<F, A>
function toYoneda<F, A>(fa: F & { value: A }): Yoneda<F, A> {
  return {
    runYoneda: <B>(f: (a: A) => B) => ({ ...fa, value: f(fa.value) })
  }
}

// Преобразование Yoneda<F, A> → F<A>
function fromYoneda<F, A>(ya: Yoneda<F, A>): F & { value: A } {
  return ya.runYoneda((x: A) => x) // применяем id
}

type Box<A> = { value: A }

function Box<A>(value: A): Box<A> {
  return { value }
}

// Обычный Box
const box = Box(10)
console.log('box', box);

// Заворачиваем в Yoneda
const ybox = toYoneda(box);
console.log('ybox', ybox);

// Применяем функцию через runYoneda
const doubled = ybox.runYoneda(x => x * 2) // Box(20)

// Возвращаем обратно
const original = fromYoneda(ybox) // Box(10)
