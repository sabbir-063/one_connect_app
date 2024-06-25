import '../../../models/CreatePostModel/admin_post_model.dart';

class AdminPostData {
  static final List<AdminPostModel> posts = [
    AdminPostModel(
      profileName: 'John Doe',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      timeAgo: '2h ago',
      postMessage: 'Help! I need money for medical expenses. Can anyone help?',
      donationNeeded: 5000,
      imageUrls: [
        'https://plus.unsplash.com/premium_photo-1663091594914-0988859bfa92?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1599059813005-11265ba4b4ce?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1683141096869-b21fb229dd02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
      ],
    ),
    AdminPostModel(
      profileName: 'Alice Johnson',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      timeAgo: '3h ago',
      postMessage: 'Urgently need support for my tuition fees.',
      donationNeeded: 3000,
      imageUrls: [
        'https://plus.unsplash.com/premium_photo-1663089601352-780e4998cc0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1663091594914-0988859bfa92?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
      ],
    ),
    AdminPostModel(
      profileName: 'Michael Smith',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
      timeAgo: '5h ago',
      postMessage: 'Need help to cover my rent this month.',
      donationNeeded: 2000,
      imageUrls: [
        'https://images.unsplash.com/photo-1593113646773-028c64a8f1b8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGRvbmF0aW9uc3xlbnwwfHwwfHx8MA%3D%3D',
      ],
    ),
    AdminPostModel(
      profileName: 'Emily Davis',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      timeAgo: '1d ago',
      postMessage: 'Raising funds for my startup business.',
      donationNeeded: 10000,
      imageUrls: [
        'https://images.unsplash.com/photo-1615897570582-285ffe259530?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGRvbmF0aW9uc3xlbnwwfHwwfHx8MA%3D%3D',
        'https://media.istockphoto.com/id/1430371482/photo/asian-volunteers-packing-donated-goods-and-groceries-at-food-bank.webp?b=1&s=170667a&w=0&k=20&c=8Wu2Vt4gU6PZx8HsaLN2-yuHm_BF_oPT9p0fTw9_u5c=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'David Brown',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      timeAgo: '2d ago',
      postMessage: 'Help needed for my sister\'s wedding expenses.',
      donationNeeded: 8000,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Sophia Martinez',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
      timeAgo: '3d ago',
      postMessage: 'Need urgent help for my child\'s surgery.',
      donationNeeded: 15000,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Chris Wilson',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
      timeAgo: '4d ago',
      postMessage: 'Collecting funds for community project.',
      donationNeeded: 7000,
      imageUrls: [
        'https://images.unsplash.com/photo-1599059813005-11265ba4b4ce?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1683141096869-b21fb229dd02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1663089601352-780e4998cc0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
      ],
    ),
    AdminPostModel(
      profileName: 'Olivia Lee',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
      timeAgo: '5d ago',
      postMessage: 'Need donations for my volunteer trip.',
      donationNeeded: 4000,
      imageUrls: [
        'https://images.unsplash.com/photo-1599059813005-11265ba4b4ce?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1683141096869-b21fb229dd02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1663089601352-780e4998cc0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
      ],
    ),
    AdminPostModel(
      profileName: 'Daniel King',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
      timeAgo: '6d ago',
      postMessage: 'Help required for my mother\'s medication.',
      donationNeeded: 6000,
      imageUrls: [
        'https://images.unsplash.com/photo-1599059813005-11265ba4b4ce?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1683141096869-b21fb229dd02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1663089601352-780e4998cc0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
      ],
    ),
    AdminPostModel(
      profileName: 'Mia Clark',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/5.jpg',
      timeAgo: '1w ago',
      postMessage: 'Need financial support for my education.',
      donationNeeded: 5000,
      imageUrls: [
        'https://images.unsplash.com/photo-1599059813005-11265ba4b4ce?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1683141096869-b21fb229dd02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1663089601352-780e4998cc0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
      ],
    ),
    AdminPostModel(
      profileName: 'Lucas Wright',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/6.jpg',
      timeAgo: '1w ago',
      postMessage: 'Raising money for my travel expenses.',
      donationNeeded: 3000,
      imageUrls: [
        'https://images.unsplash.com/photo-1599059813005-11265ba4b4ce?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1683141096869-b21fb229dd02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1663089601352-780e4998cc0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
      ],
    ),
    AdminPostModel(
      profileName: 'Emma Walker',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/6.jpg',
      timeAgo: '1w ago',
      postMessage: 'Need funds for a charity event.',
      donationNeeded: 2000,
      imageUrls: [
        'https://images.unsplash.com/photo-1599059813005-11265ba4b4ce?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1683141096869-b21fb229dd02?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1663089601352-780e4998cc0f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9uYXRpb25zfGVufDB8fDB8fHww',
      ],
    ),
    AdminPostModel(
      profileName: 'James Hall',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/7.jpg',
      timeAgo: '2w ago',
      postMessage: 'Need support for my local animal shelter.',
      donationNeeded: 9000,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Ava Harris',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/7.jpg',
      timeAgo: '2w ago',
      postMessage: 'Need financial help for my art project.',
      donationNeeded: 7000,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Logan Young',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/8.jpg',
      timeAgo: '3w ago',
      postMessage: 'Need help to rebuild my house after the fire.',
      donationNeeded: 10000,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Charlotte Green',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/8.jpg',
      timeAgo: '3w ago',
      postMessage: 'Fundraising for my marathon participation.',
      donationNeeded: 1500,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Henry Adams',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/9.jpg',
      timeAgo: '1mo ago',
      postMessage: 'Need help to publish my book.',
      donationNeeded: 4000,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Amelia Nelson',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/9.jpg',
      timeAgo: '1mo ago',
      postMessage: 'Collecting funds for a wildlife conservation project.',
      donationNeeded: 12000,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Alexander Robinson',
      profilePicUrl: 'https://randomuser.me/api/portraits/men/10.jpg',
      timeAgo: '1mo ago',
      postMessage: 'Need support for my sports team\'s travel expenses.',
      donationNeeded: 2500,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
    AdminPostModel(
      profileName: 'Isabella Carter',
      profilePicUrl: 'https://randomuser.me/api/portraits/women/10.jpg',
      timeAgo: '1mo ago',
      postMessage: 'Need funds to buy new equipment for my workshop.',
      donationNeeded: 3500,
      imageUrls: [
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
        'https://media.istockphoto.com/id/1185501448/photo/donation-concept.webp?b=1&s=170667a&w=0&k=20&c=qvjTDb29bYSTuYfL_DkK1NM9JULFe8iE3TSXKIY8nRQ=',
      ],
    ),
  ];
}
