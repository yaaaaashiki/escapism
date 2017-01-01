[Thesis, Author].each(&:delete_all)
Author.seed (
  :id,
  { id: 1,
    name: '松本　樹生'
  }
  { id: 2,
    name: '佐久田　博'
  }
)

Thesis.seed (
  :id,
  { id: 1,
    author: matsumoto, 
    year: 2016, comment: '', 
    url: '/users/buntu/thesis_data/test1.pdf', 
    pdf: 'プロテウス効果が発生すると良いなwww'
  },
  { id: 2,
    author: matsumoto, 
    year: 2017, comment: '', 
    url: '/users/buntu/thesis_data/test2.pdf', 
    pdf: 'Githubが使えると良いなwww'
  },
  { id: 3,
    author: matsumoto, 
    year: 2018, comment: '', 
    url: '/users/buntu/thesis_data/test3.pdf', 
    pdf: 'Subversionよくわからんwww'
  },
  { id: 4,
    author: sakuta, 
    year: 2016, comment: '', 
    url: '/users/buntu/thesis_data/test4.pdf', 
    pdf: 'Ruby on Rails良いね！！'
  },
  { id: 5,
    author: sakuta, 
    year: 2017, comment: '', 
    url: '/users/buntu/thesis_data/test5.pdf', 
    pdf: 'Slack kkkkkwww'
  },
  { id: 6,
    author: sakuta, 
    year: 2018, comment: '',
    url: '/users/buntu/thesis_data/test6.pdf', 
    pdf: 'mac欲しいけど\nお金ない(´；ω；｀)'
  }
)