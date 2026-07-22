import '../models/role_model.dart';

class RolesData {
  static const List<RoleModel> roles = [
    RoleModel(
      id: 'web_dev',
      title: 'Web Developer',
      description: 'Build modern web applications and websites',
      icon: '🌐',
      color: '3B5BDB',
      requiredSkills: [
        'HTML', 'CSS', 'JavaScript', 'React', 'Node.js',
        'REST APIs', 'Git', 'TypeScript', 'Responsive Design', 'SQL',
      ],
      resources: {
        'React Official Docs': 'https://react.dev/',
        'JavaScript Info': 'https://javascript.info/',
        'MDN Web Docs': 'https://developer.mozilla.org/',
      },
    ),
    RoleModel(
      id: 'flutter_dev',
      title: 'Flutter Developer',
      description: 'Cross-platform mobile app development',
      icon: '📱',
      color: '0891B2',
      requiredSkills: [
        'Flutter', 'Dart', 'State Management', 'REST APIs', 'Git',
        'Firebase', 'UI/UX Design', 'Android', 'iOS', 'SQLite',
      ],
      resources: {
        'Flutter Official Docs': 'https://flutter.dev/docs',
        'Dart Language Tour': 'https://dart.dev/language',
        'Flutter YouTube Channel': 'https://www.youtube.com/c/flutterdev',
      },
    ),
    RoleModel(
      id: 'data_analyst',
      title: 'Data Analyst',
      description: 'Analyze data and generate actionable insights',
      icon: '📊',
      color: '7C3AED',
      requiredSkills: [
        'Python', 'SQL', 'Excel', 'Tableau', 'Power BI',
        'Statistics', 'Pandas', 'NumPy', 'Data Visualization', 'Machine Learning',
      ],
      resources: {
        'Kaggle Free Courses': 'https://www.kaggle.com/learn',
        'Pandas Documentation': 'https://pandas.pydata.org/docs/',
        'SQL Tutorial': 'https://www.w3schools.com/sql/',
      },
    ),
    RoleModel(
      id: 'ui_ux',
      title: 'UI/UX Designer',
      description: 'Design intuitive and beautiful user experiences',
      icon: '🎨',
      color: 'DB2777',
      requiredSkills: [
        'Figma', 'Adobe XD', 'Prototyping', 'User Research', 'Wireframing',
        'Design Systems', 'Usability Testing', 'CSS', 'Typography', 'Color Theory',
      ],
      resources: {
        'Figma Learn': 'https://www.figma.com/resources/learn-design/',
        'Nielsen Norman Group': 'https://www.nngroup.com/',
        'Laws of UX': 'https://lawsofux.com/',
      },
    ),
    RoleModel(
      id: 'backend_dev',
      title: 'Backend Developer',
      description: 'Build scalable server-side systems and APIs',
      icon: '⚙️',
      color: '059669',
      requiredSkills: [
        'Python', 'Node.js', 'SQL', 'NoSQL', 'REST APIs',
        'Docker', 'AWS', 'Git', 'System Design', 'Authentication',
      ],
      resources: {
        'Node.js Docs': 'https://nodejs.org/en/docs/',
        'System Design Primer': 'https://github.com/donnemartin/system-design-primer',
        'Docker Getting Started': 'https://docs.docker.com/get-started/',
      },
    ),
    RoleModel(
      id: 'ml_engineer',
      title: 'ML Engineer',
      description: 'Build and deploy machine learning models',
      icon: '🤖',
      color: 'DC2626',
      requiredSkills: [
        'Python', 'TensorFlow', 'PyTorch', 'Machine Learning', 'Deep Learning',
        'SQL', 'Statistics', 'Docker', 'MLOps', 'Data Preprocessing',
      ],
      resources: {
        'TensorFlow Tutorials': 'https://www.tensorflow.org/tutorials',
        'Fast.ai Practical Deep Learning': 'https://course.fast.ai/',
        'Machine Learning Mastery': 'https://machinelearningmastery.com/',
      },
    ),
    RoleModel(
      id: 'product_manager',
      title: 'Product Manager',
      description: 'Lead product strategy, vision, and execution',
      icon: '🎯',
      color: 'D97706',
      requiredSkills: [
        'Product Strategy', 'Agile Methodologies', 'User Research', 'Data Analysis',
        'Roadmapping', 'A/B Testing', 'Stakeholder Management', 'Jira', 'UX Principles', 'Market Research',
      ],
      resources: {
        'Product School YouTube': 'https://www.youtube.com/c/ProductSchoolSanFrancisco',
        'SVPG Silicon Valley Product Group': 'https://svpg.com/articles/',
        'Mind the Product': 'https://www.mindtheproduct.com/',
      },
    ),
    RoleModel(
      id: 'cloud_engineer',
      title: 'Cloud Engineer',
      description: 'Design and manage cloud infrastructure',
      icon: '☁️',
      color: '2563EB',
      requiredSkills: [
        'AWS', 'Azure', 'GCP', 'Linux', 'Networking',
        'Terraform', 'Kubernetes', 'Docker', 'CI/CD', 'Security',
      ],
      resources: {
        'AWS Training': 'https://aws.amazon.com/training/',
        'Terraform Learn': 'https://learn.hashicorp.com/terraform',
        'Kubernetes Basics': 'https://kubernetes.io/docs/tutorials/kubernetes-basics/',
      },
    ),
    RoleModel(
      id: 'cybersecurity',
      title: 'Cybersecurity Analyst',
      description: 'Protect systems and networks from cyber threats',
      icon: '🛡️',
      color: '1D4ED8',
      requiredSkills: [
        'Network Security', 'Linux', 'Ethical Hacking', 'Risk Assessment',
        'SIEM', 'Python', 'Cryptography', 'Incident Response', 'Vulnerability Scanning', 'Firewalls',
      ],
      resources: {
        'TryHackMe': 'https://tryhackme.com/',
        'Hack The Box': 'https://www.hackthebox.com/',
        'Cybrary': 'https://www.cybrary.it/',
      },
    ),
    RoleModel(
      id: 'devops',
      title: 'DevOps Engineer',
      description: 'Streamline development and deployment processes',
      icon: '🔄',
      color: '4F46E5',
      requiredSkills: [
        'Linux', 'Bash', 'Git', 'Jenkins', 'Docker',
        'Kubernetes', 'Ansible', 'Terraform', 'AWS', 'Monitoring',
      ],
      resources: {
        'DevOps Roadmap': 'https://roadmap.sh/devops',
        'Jenkins Pipeline Docs': 'https://www.jenkins.io/doc/book/pipeline/',
        'Ansible Documentation': 'https://docs.ansible.com/',
      },
    ),
    RoleModel(
      id: 'ios_dev',
      title: 'iOS Developer',
      description: 'Build native applications for Apple devices',
      icon: '🍏',
      color: '4B5563',
      requiredSkills: [
        'Swift', 'Objective-C', 'Xcode', 'UIKit', 'SwiftUI',
        'Core Data', 'REST APIs', 'Git', 'App Store Connect', 'Combine',
      ],
      resources: {
        'Swift Documentation': 'https://swift.org/documentation/',
        'Hacking with Swift': 'https://www.hackingwithswift.com/',
        'Apple Developer Tutorials': 'https://developer.apple.com/tutorials/swiftui',
      },
    ),
    RoleModel(
      id: 'android_dev',
      title: 'Android Developer',
      description: 'Build native applications for Android devices',
      icon: '🤖',
      color: '16A34A',
      requiredSkills: [
        'Kotlin', 'Java', 'Android Studio', 'Jetpack Compose', 'MVVM',
        'Room Database', 'Retrofit', 'Coroutines', 'Git', 'Firebase',
      ],
      resources: {
        'Android Developer Guides': 'https://developer.android.com/guide',
        'Kotlin Documentation': 'https://kotlinlang.org/docs/home.html',
        'Google Codelabs Android': 'https://codelabs.developers.google.com/?cat=Android',
      },
    ),
    RoleModel(
      id: 'blockchain_dev',
      title: 'Blockchain Developer',
      description: 'Develop decentralized applications and smart contracts',
      icon: '⛓️',
      color: 'F59E0B',
      requiredSkills: [
        'Solidity', 'Ethereum', 'Web3.js', 'Smart Contracts', 'Cryptography',
        'Node.js', 'Rust', 'Hardhat', 'Truffle', 'DeFi',
      ],
      resources: {
        'Solidity Docs': 'https://docs.soliditylang.org/',
        'CryptoZombies': 'https://cryptozombies.io/',
        'Web3.js Documentation': 'https://web3js.readthedocs.io/',
      },
    ),
    RoleModel(
      id: 'game_dev',
      title: 'Game Developer',
      description: 'Create interactive video games and experiences',
      icon: '🎮',
      color: '9333EA',
      requiredSkills: [
        'C#', 'C++', 'Unity', 'Unreal Engine', '3D Math',
        'Physics Engines', 'Game Design', 'Blender', 'Shaders', 'Git',
      ],
      resources: {
        'Unity Learn': 'https://learn.unity.com/',
        'Unreal Engine Tutorials': 'https://dev.epicgames.com/community/unreal-engine/getting-started',
        'Brackeys YouTube': 'https://www.youtube.com/c/Brackeys',
      },
    ),
    RoleModel(
      id: 'qa_engineer',
      title: 'QA Engineer',
      description: 'Ensure software quality through automated and manual testing',
      icon: '✅',
      color: '0D9488',
      requiredSkills: [
        'Manual Testing', 'Automated Testing', 'Selenium', 'Cypress', 'Postman',
        'Java', 'Python', 'Jira', 'CI/CD', 'API Testing',
      ],
      resources: {
        'Selenium Docs': 'https://www.selenium.dev/documentation/',
        'Cypress Learning Center': 'https://learn.cypress.io/',
        'Postman API Testing': 'https://learning.postman.com/docs/writing-scripts/test-scripts/',
      },
    ),
  ];
}
