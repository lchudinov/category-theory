type Contact =
  | {tag: 'phone'; phoneNum: number}
  | {tag: 'email'; emailAddr: string}
  
function PhoneNum(num: number): Contact {
  return {
    tag: 'phone',
    phoneNum: num,
  };
}