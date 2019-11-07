from amazon.ion.simpleion import loads, dumps
import ionhash
import base64
from qldb import QldbHash

def get_digest(transaction_id, statement, parameters=[]):
  transaction_id = transaction_id.decode("utf-8")
  statement = statement.decode("utf-8")

  statement_hash = QldbHash.to_qldb_hash(statement)
  transaction_id_hash = QldbHash.to_qldb_hash(transaction_id)

  for param in parameters:
    if isinstance(param, bytes):
      param = param.decode("utf-8")

    param = str(param)

    statement_hash = statement_hash.dot(QldbHash.to_qldb_hash(param))

  statement_hash = transaction_id_hash.dot(statement_hash)

  return base64.b64encode(statement_hash.get_qldb_hash()).decode("utf-8")
