# -*- coding: utf-8 -*-

from gensim.summarization.summarizer import summarize
import sys

if __name__ == '__main__':
  if len(sys.argv) != 2:
    raise

  print(summarize(sys.argv[1], word_count=250))