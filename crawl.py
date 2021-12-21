import sys
import os
import subprocess

TEMP_DIRECTORY_NAME = 'crawl'

def stripLines(lines):
    return [l.strip('\n') for l in lines]

def cmdOutputLines(cmd):
    return stripLines(os.popen(cmd).readlines())



def printTree(tree, path=''):
    files = []
    tree_contents = cmdOutputLines(f"git cat-file -p {tree}")
    path += '/'
    for c in tree_contents:
        c_type = c.split(' ')[1]
        c_hash = c.split(' ')[2].split("\t")[0]
        c_name = c.split(' ')[2].split("\t")[1]
        if(c_type == 'blob'):
            md5_hash = cmdOutputLines('git cat-file -p ' + c_hash + ' | md5sum')[0].split(' ')[0]
            files.append([c_hash, md5_hash, path + c_name])
        if(c_type == 'tree'):
            files.extend(printTree(c_hash, path + c_name))
    return files

def walkCommit(commit):
    commit_hash = commit.split(' ')[0]
    lines = cmdOutputLines(f"git cat-file -p {commit_hash} | head -n 2")
    d = dict([ (l.split(' ')[0], l.split(' ')[1]) for l in lines ])
    return printTree(d['tree'], commit.split(' ')[1])
    #if 'parent' in d:
        #walkCommit(d['parent'])

def main():
    repo = sys.argv[1]
    

    os.mkdir(TEMP_DIRECTORY_NAME)
    os.chdir(TEMP_DIRECTORY_NAME)
    


    repo_name = repo.split('/')[1]

    url = "https://github.com/" + repo
    subprocess.run(args=["git", "clone", "--mirror", url], stderr=subprocess.DEVNULL)
    commits = cmdOutputLines('cat ' + repo_name + '.git/packed-refs | grep refs/tags/')
    
    os.chdir(repo_name + '.git')

    processed_data = []
    
    for c in commits:
        walkedCommit = walkCommit(c)
        for w in walkedCommit:
            print('')
            processed_data.append([repo_name, c.split(' ')[1].split('/')[2], w[2], w[0], w[1]])

    for p in processed_data:
        print(p)

    os.chdir('..')
    subprocess.run(args=['rm','-rf', TEMP_DIRECTORY_NAME])

main()
