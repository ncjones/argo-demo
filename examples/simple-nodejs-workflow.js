function errorExit(err) {
  console.error(err);
  process.exit(1);
}

async function main() {
  return 'Hello World!';
}

main()
  .then(console.log)
  .catch(errorExit);
