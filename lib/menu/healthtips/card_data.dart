final List<MedicalInfoCard> demoCards = [
  new MedicalInfoCard(
      header: "Copy your kitty",
      description:
          "Learn to do stretching exercises when you wake up. It boosts circulation and digestion, and eases back pain."),
  new MedicalInfoCard(
      header: "Don’t skip breakfast",
      description:
          "Studies show that eating a proper breakfast is one of the most positive things you can do if you are trying to lose weight. Breakfast skippers tend to gain weight. A balanced breakfast includes fresh fruit or fruit juice, a high-fibre breakfast cereal, low-fat milk or yoghurt, wholewheat toast, and a boiled egg."),
  new MedicalInfoCard(
      header: "Brush up on hygiene",
      description:
          "Many people don't know how to brush their teethproperly. Improper brushing can cause as much damage to the teeth and gums as not brushing at all. Lots of people don’t brush for long enough, don’t floss and don’t see a dentist regularly. Hold your toothbrush in the same way that would hold a pencil, and brush for at least two minutes. "),
  new MedicalInfoCard(
      header: "Neurobics for your mind",
      description:
          "Get your brain fizzing with energy. American researchers coined the term /‘neurobics/’ for tasks which activate the brain/'s own biochemical pathways and to bring new pathways online that can help to strengthen or preserve brain circuits.Brush your teeth with your /‘other/’ hand, take a new route to work or choose your clothes based on sense of touch rather than sight. People with mental agility tend to have lower rates of Alzheimer/'s disease and age-related mental decline."),
  new MedicalInfoCard(
      header: "Get what you give",
      description:
          "Always giving and never taking? This is the short road to compassion fatigue. Give to yourself and receive from others, otherwise you’ll get to a point where you have nothing left to give. And hey, if you can’t receive from others, how can you expect them to receive from you?"),
  new MedicalInfoCard(
      header: "Get spiritual",
      description:
          "A study conducted by the formidably sober and scientific Harvard University found that patients who were prayed for recovered quicker than those who weren’t, even if they weren’t aware of the prayer."),
  new MedicalInfoCard(
    header: "Get smelly",
    description: "Garlic, onions, spring onions and leeks all contain stuff that’s good for you. A study at the Child’s Health Institute in Cape Town found that eating raw garlic helped fight serious childhood infections. Heat destroys these properties, so eat yours raw, wash it down with fruit juice or, if you’re a sissy, have it in tablet form."
  ),
  new MedicalInfoCard(
    header: "Knock one back",
    description: " A glass of red wine a day is good for you. A number of studies have found this, but a recent one found that the polyphenols (a type of antioxidant) in green tea, red wine and olives may also help protect you against breast cancer. It’s thought that the antioxidants help protect you from environmental carcinogens such as passive tobacco smoke."
  ),
  new MedicalInfoCard(
    header: "Bone up daily",
    description: "Get your daily calcium by popping a tab, chugging milk or eating yoghurt. It’ll keep your bones strong. Remember that your bone density declines after the age of 30. You need at least 200 milligrams daily, which you should combine with magnesium, or it simply won’t be absorbed."
  ),
  new MedicalInfoCard(
    header: "Berries for your belly",
    description: "Blueberries, strawberries and raspberries contain plant nutrients known as anthocyanidins, which are powerful antioxidants. Blueberries rival grapes in concentrations of resveratrol – the antioxidant compound found in red wine that has assumed near mythological proportions. Resveratrol is believed to help protect against heart disease and cancer."
  )
];

class MedicalInfoCard {
  final String header;
  final description;

  MedicalInfoCard({
    this.header,
    this.description,
  });
}
