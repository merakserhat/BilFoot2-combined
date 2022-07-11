export const getNameFromMail = (email: string): string => {
  let words = email.split("@")[0].split(".");
  words.forEach(
    (word, index) =>
      (words[index] = word.charAt(0).toUpperCase() + word.slice(1))
  );
  return words.join(" ");
};
