defmodule ExAws.QLDB do
  @type pagination :: [
    {:max_results, binary} |
    {:next_token, binary}
  ]

  @actions %{
    create_ledger: :post,
    delete_ledger: :delete,
    describe_journal_s3export: :get,
    describe_ledger: :get,
    export_journal_to_s3: :post,
    get_block: :post,
    get_digest: :post,
    get_revision: :post,
    list_journal_s3exports: :get,
    list_journal_s3exports_for_ledger: :get,
    list_ledgers: :get,
    list_tags_for_resource: :get,
    tag_resource: :post,
    untag_resource: :delete,
    update_ledger: :patch,
  }

  @spec create_ledger(
    name :: binary
  ) :: ExAws.Operation.JSON.t
  @spec create_ledger(
    name :: binary,
    permission_mode :: binary
  ) :: ExAws.Operation.JSON.t
  @spec create_ledger(
    name :: binary,
    permission_mode :: binary,
    deletion_protection :: binary
  ) :: ExAws.Operation.JSON.t
  @spec create_ledger(
    name :: binary,
    permission_mode :: binary,
    deletion_protection :: binary,
    tags :: binary
  ) :: ExAws.Operation.JSON.t
  def create_ledger(name, permission_mode \\ "ALLOW_ALL", deletion_protection \\ false, tags \\ %{}) do
    data = %{
      "Name" => name,
      "PermissionsMode" =>  permission_mode,
      "DeletionProtection" => deletion_protection,
      "Tags" => tags
    }

    request(:create_ledger, data, "/ledgers")
  end

  @spec delete_ledger(
    name :: binary
  ) :: ExAws.Operation.JSON.t
  def delete_ledger(name) do
    request(:delete_ledger, %{}, "/ledgers/#{name}")
  end

  @spec describe_journal_s3export(
    name :: binary,
    export_id :: binary
  ) :: ExAws.Operation.JSON.t
  def describe_journal_s3export(name, export_id) do
    request(:describe_journal_s3export, %{}, "/ledgers/#{name}/journal-s3-exports/#{export_id}")
  end

  @spec describe_ledger(
    name :: binary
  ) :: ExAws.Operation.JSON.t
  def describe_ledger(name) do
    request(:describe_ledger, %{}, "/ledgers/#{name}")
  end

  @type export_journal_to_s3_opts :: [
    {:exclusive_end_time, pos_integer} |
    {:inclusive_start_time, pos_integer} |
    {:role_arn, binary} |
    {:s3_bucket, binary} |
    {:s3_kms_key_arn, binary} |
    {:object_encryption_type, binary} |
    {:prefix, binary}
  ]

  @spec export_journal_to_s3(
    name :: binary,
    opts :: export_journal_to_s3_opts
  ) :: ExAws.Operation.JSON.t
  def export_journal_to_s3(name, opts) do
    data = %{
      "ExclusiveEndTime" => opts.exclusive_end_time,
      "InclusiveStartTime" => opts.inclusive_start_time,
      "RoleArn" => opts.role_arn,
      "S3ExportConfiguration" => %{ 
         "Bucket" => opts.s3_bucket,
         "EncryptionConfiguration" => %{ 
            "KmsKeyArn" => opts.s3_kms_key_arn,
            "ObjectEncryptionType" => opts.object_encryption_type
         },
         "Prefix" => opts.prefix
      }
   }
    
    request(:export_journal_to_s3, data, "/ledgers/#{name}/journal-s3-exports")
  end

  @type get_block_opts :: [
    {:block_address, binary} |
    {:digest_tip_address, binary}
  ]
  @spec get_block(
    name :: binary,
    opts :: get_block_opts
  ) :: ExAws.Operation.JSON.t
  def get_block(name, opts) do
    data = %{
      "BlockAddress" => %{ 
         "IonText" => opts.block_address
      },
      "DigestTipAddress" => %{ 
         "IonText" => opts.digest_tip_address
      }
   }

    request(:get_block, data, "/ledgers/#{name}/block")
  end

  @spec get_digest(
    name :: binary
  ) :: ExAws.Operation.JSON.t
  def get_digest(name) do
    request(:get_digest, %{}, "/ledgers/#{name}/digest")
  end

  @type get_revision_opts :: [
    {:block_address, binary} |
    {:digest_tip_address, binary} |
    {:document_id, binary}
  ]
  @spec get_revision(
    name :: binary,
    opts :: get_block_opts
  ) :: ExAws.Operation.JSON.t
  def get_revision(name, opts) do
    data = %{
      "BlockAddress" => %{ 
         "IonText" => opts.block_address
      },
      "DigestTipAddress" => %{ 
         "IonText" => opts.digest_tip_address
      },
      "DocumentId" => opts.document_id
    }

    request(:get_revision, data, "/ledgers/#{name}/revision")
  end

  @spec list_journal_s3exports(
    opts :: pagination
  ) :: ExAws.Operation.JSON.t
  def list_journal_s3exports(opts) do
    params = %{
      max_results: opts.max_results,
      next_token: opts.next_token,
    }

    request(:list_journal_s3exports, %{}, "/journal-s3-exports", params)
  end

  @spec list_journal_s3exports_for_ledger(
    name :: binary,
    opts :: pagination
  ) :: ExAws.Operation.JSON.t
  def list_journal_s3exports_for_ledger(name, opts) do
    params = %{
      max_results: opts.max_results,
      next_token: opts.next_token,
    }

    request(:list_journal_s3exports_for_ledger, %{}, "/ledgers/#{name}/journal-s3-exports", params)
  end

  @spec list_ledgers(
    opts :: pagination
  ) :: ExAws.Operation.JSON.t
  def list_ledgers(opts) do
    params = %{
      max_results: opts.max_results,
      next_token: opts.next_token,
    }

    request(:list_ledgers, %{}, "/ledgers", params)
  end

  @spec list_tags_for_resource(
    resource_arn :: binary
  ) :: ExAws.Operation.JSON.t
  def list_tags_for_resource(resource_arn) do
    request(:list_tags_for_resource, %{}, "/tags/#{resource_arn}")
  end

  @spec tag_resource(
    resource_arn :: binary,
    tags :: binary
  ) :: ExAws.Operation.JSON.t
  def tag_resource(resource_arn, tags) do
    data = %{
      "Tags" => tags
    }

    request(:tag_resource, data, "/tags/#{resource_arn}")
  end

  @spec untag_resource(
    resource_arn :: binary,
    tag_keys :: binary
  ) :: ExAws.Operation.JSON.t
  def untag_resource(resource_arn, tag_keys) do
    params = %{
      "tagKeys" => tag_keys
    }

    request(:untag_resource, %{}, "/tags/#{resource_arn}", params)
  end

  @spec untag_resource(
    name :: binary,
    deletion_protection :: binary
  ) :: ExAws.Operation.JSON.t
  def update_ledger(name, deletion_protection) do
    data = %{
      "DeletionProtection" => deletion_protection
    }

    request(:update_ledger, data, "/ledgers/#{name}")
  end

  defp request(action, data, path, params \\ [], headers \\ []) do
    path = [path, "?", params |> URI.encode_query] |> IO.iodata_to_binary
    http_method = @actions |> Map.fetch!(action)

    ExAws.Operation.JSON.new(:qldb, %{
      http_method: http_method,
      path: path,
      data: data,
      headers: [{"content-type", "application/json"} | headers],
    })
  end
end

