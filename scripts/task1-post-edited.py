#!/usr/bin/env python3

import sys, os
import argparse

def main(args):
    num_post_edited = 0
    for i, (l1, l2) in enumerate(zip(open(args.pre_edit_file), open(args.post_edit_file))):
        l1 = l1.strip()
        l2 = l2.strip()
        is_diff = l1 != l2

        if args.print_line_num:
            if is_diff:
                print(i)
                if args.print_text:
                    print(l1)
                    print(l2)
        else:
            print(1 if is_diff else 0)

        if is_diff:
            num_post_edited += 1
        
    print(f'Found {num_post_edited} edits.', file=sys.stderr)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--pre-edit-file', default='./data/task1/raw-wmt16/test.de')
    parser.add_argument('--post-edit-file', default='./data/task1/raw/test_2016_flickr.de')
    parser.add_argument('--print-text', action='store_true')
    parser.add_argument('--print-line-num', action='store_true')

    main(parser.parse_args())
