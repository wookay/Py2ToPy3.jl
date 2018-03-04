# Py2ToPy3

Some replacements of python 2 => python 3

* replace `print`
```python2
print "A"
```
 => 
```python3
print("A")
```

* replace `except`, `raise`

### overwrite it to the python file

```sh
$ julia -e 'using Py2ToPy3; change(overwrite=true)' hello.py
```
