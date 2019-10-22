export const booksQuery = (params) => {
  return `
    query { 
      books(${makeVariables(params.variables)}) {
        ${params.fields.toString()}
      }
    }`
}

const makeVariables = (params) => {
  let tmpVal = ''
  const keys = Object.keys(params)
  if (keys.length === 0) {
    return tmpVal
  }
  keys.forEach(key => {
    tmpVal += `${key}: ${params[key]},`
  })
  return tmpVal.slice(0, -1)
}