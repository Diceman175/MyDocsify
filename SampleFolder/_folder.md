# Sample Folder Text File

- [Sample1](..\Sample.md) | MD = yes | GH = No | HTML = 404
- [Sample2](.\Sample.md) | MD = no | GH = no | HTML = yes displays as /.\Sample
- [Sample3](./Sample.md) | MD no | | GH = no | HTML = yes displays as /./Sample
- [Sample4](../Sample.md) | MD = yes | GH = yes | HTML = 404 
- [Sample5](/Sample.md) | | MD - no | GH = yes | HTML = yes displays /Sample
- [Sample6](/.Sample.md) | MD = no | GH = no | HTML = 404
- [Sample7](/..Sample.md) | MD = no | GH = no | HTML = 404
- [Template.md](..\template.md) Works in MD
- [Template.txt](..\template.txt) Works in MD
- [README.md](..\README.md) | Works in MD

[Sample8][l_src] | MD = no | GH = no | HTML = 404

  [l_src]: /Sample.md