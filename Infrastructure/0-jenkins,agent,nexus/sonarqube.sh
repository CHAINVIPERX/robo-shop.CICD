#!/bin/bash
sudo labauto <<EOF
60
EOF

# Explanation:

#     <<EOF: This starts a heredoc block, and EOF is a delimiter that indicates the end of the block.

#     The lines between <<EOF and EOF are treated as input to the labauto command.