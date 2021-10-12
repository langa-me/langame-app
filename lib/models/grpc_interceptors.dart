import 'package:grpc/grpc.dart';

/// This is a client stream interceptor for gRPC
/// It is used to add a header to the request
class ClientFirebaseAuthInterceptor implements ClientInterceptor {
  final String _authToken;
  ClientFirebaseAuthInterceptor(this._authToken);
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    return invoker(
      method,
      requests,
      options = options.mergedWith(
        CallOptions(metadata: {'authorization': 'bearer $_authToken'}),
      ),
    );
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    return invoker(
      method,
      request,
      options.mergedWith(
        CallOptions(metadata: {'authorization': 'bearer $_authToken'}),
      ),
    );
  }
}
