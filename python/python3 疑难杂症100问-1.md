# python3

# 疑难杂症100问

#### 问题 1
```
Unclosed connector
connections: ['[(<aiohttp.client_proto.ResponseHandler object at 0x000002AB27476898>, 1473112.843)]']
connector: <aiohttp.connector.TCPConnector object at 0x000002AB2595C908>
Fatal error on SSL transport
protocol: <asyncio.sslproto.SSLProtocol object at 0x000002AB276E1D88>
transport: <_SelectorSocketTransport closing fd=1308>
Traceback (most recent call last):
  File "D:\ProgramData\.pyenv\pyenv-win\versions\3.7.4-amd64\Lib\asyncio\selector_events.py", line 860, in write
    n = self._sock.send(data)
OSError: [WinError 10038] 在一个非套接字上尝试了一个操作。

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "D:\ProgramData\.pyenv\pyenv-win\versions\3.7.4-amd64\Lib\asyncio\sslproto.py", line 680, in _process_write_backlog
    self._transport.write(chunk)
  File "D:\ProgramData\.pyenv\pyenv-win\versions\3.7.4-amd64\Lib\asyncio\selector_events.py", line 864, in write
    self._fatal_error(exc, 'Fatal write error on socket transport')
  File "D:\ProgramData\.pyenv\pyenv-win\versions\3.7.4-amd64\Lib\asyncio\selector_events.py", line 673, in _fatal_error
    self._force_close(exc)
  File "D:\ProgramData\.pyenv\pyenv-win\versions\3.7.4-amd64\Lib\asyncio\selector_events.py", line 685, in _force_close
    self._loop.call_soon(self._call_connection_lost, exc)
  File "D:\ProgramData\.pyenv\pyenv-win\versions\3.7.4-amd64\Lib\asyncio\base_events.py", line 683, in call_soon
    self._check_closed()
  File "D:\ProgramData\.pyenv\pyenv-win\versions\3.7.4-amd64\Lib\asyncio\base_events.py", line 475, in _check_closed
    raise RuntimeError('Event loop is closed')
RuntimeError: Event loop is closed
```
#### 分析：
#### 方案：


