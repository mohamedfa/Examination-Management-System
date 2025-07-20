const bcrypt = require('bcryptjs');
const fs = require('fs');

async function generateHash() {
  const hash = await bcrypt.hash('password123', 10);
  const output = `Generated hash for password123:\n${hash}`;
  console.log(output);
  fs.writeFileSync('password_hash.txt', output);
}

generateHash();