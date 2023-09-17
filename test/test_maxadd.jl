# this function will return the (i, j) element of the Tropical result of C + A * B
function direct_maxadd(A::Matrix{T}, B::Matrix{T}, C::Matrix{T}, i::Int, j::Int) where{T}
    K = size(A)[2]

    sum = C[i, j]

    for k in 1:K
        sum = max(sum, A[i, k] + B[k, j])
    end

    return sum
end

function check_all(A::Matrix{T}, B::Matrix{T}, C::Matrix{T}, D::Matrix{T}) where{T}
    M = size(A)[1]
    K = size(A)[2]
    N = size(B)[2]
    
    for i in 1:M
        for j in 1:N
            sum = C[i, j]

            for k in 1:K
                sum = max(sum, A[i, k] + B[k, j])
            end

            if sum ≉ D[i, j]
                @show i, j, sum, D[i, j]
                return false
            end
        end
    end

    return true
end

@testset "Testing Matrix Max Add" begin
    # M = rand(3000:6000)
    # N = rand(3000:6000)
    # K = rand(3000:6000)

    M = 1025
    N = 1025
    K = 1025

    @show M, N, K
    @testset "Float32 max add" begin 
        A = 2f0 .* rand(Float32, M, K) .- 1f0
        B = 2f0 .* rand(Float32, K, N) .- 1f0
        C = 2f0 .* rand(Float32, M, N) .- 1f0

        CuA = CuArray(A)
        CuB = CuArray(B)
        CuC = CuArray(C)

        maxadd!(CuA, CuB, CuC)

        D = Array(CuC)

        # for _ in 1:100
        #     i = rand(1:M)
        #     j = rand(1:N)
        #     @test D[i, j] ≈ direct_maxadd(A, B, C, i, j)
        # end
        @test check_all(A, B, C, D)
    end

    @testset "Float64 max add" begin
        A = 2.0 .* rand(Float64, M, K) .- 1.0
        B = 2.0 .* rand(Float64, K, N) .- 1.0
        C = 2.0 .* rand(Float64, M, N) .- 1.0

        CuA = CuArray(A)
        CuB = CuArray(B)
        CuC = CuArray(C)

        maxadd!(CuA, CuB, CuC)

        D = Array(CuC)

        # for _ in 1:100
        #     i = rand(1:M)
        #     j = rand(1:N)
        #     @test D[i, j] ≈ direct_maxadd(A, B, C, i, j)
        # end

        @test check_all(A, B, C, D)
    end

    @testset "Int32 max add" begin
        A = Int32(2) .* rand(Int32, M, K) .- Int32(1)
        B = Int32(2) .* rand(Int32, K, N) .- Int32(1)
        C = Int32(2) .* rand(Int32, M, N) .- Int32(1)

        CuA = CuArray(A)
        CuB = CuArray(B)
        CuC = CuArray(C)

        maxadd!(CuA, CuB, CuC)

        D = Array(CuC)

        # for _ in 1:100
        #     i = rand(1:M)
        #     j = rand(1:N)
        #     @test D[i, j] ≈ direct_maxadd(A, B, C, i, j)
        # end

        @test check_all(A, B, C, D)
    end

    @testset "Int64 max add" begin
        A = Int64(2) .* rand(Int64, M, K) .- Int64(1)
        B = Int64(2) .* rand(Int64, K, N) .- Int64(1)
        C = Int64(2) .* rand(Int64, M, N) .- Int64(1)

        CuA = CuArray(A)
        CuB = CuArray(B)
        CuC = CuArray(C)

        maxadd!(CuA, CuB, CuC)

        D = Array(CuC)

        # for _ in 1:100
        #     i = rand(1:M)
        #     j = rand(1:N)
        #     @test D[i, j] ≈ direct_maxadd(A, B, C, i, j)
        # end

        @test check_all(A, B, C, D)
    end
end